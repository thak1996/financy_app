require("dotenv").config();

const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const fetch = require("node-fetch");

admin.initializeApp();

const makeGraphQLRequest = async (query, variables = {}) => {
  const endpoint = process.env.GRAPHQL_ENDPOINT;
  const secret = process.env.HASURA_ADMIN_SECRET;

  try {
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-hasura-admin-secret": secret,
      },
      body: JSON.stringify({query, variables}),
    });

    const text = await response.text();

    let result;
    try {
      result = JSON.parse(text);
    } catch (e) {
      throw new Error(`Failed to parse JSON: ${text}`);
    }

    if (!response.ok) {
      throw new Error(`GraphQL request failed with status ${response.status}`);
    }

    if (result.errors) {
      throw new Error(result.errors[0].message);
    }

    return result.data;
  } catch (error) {
    console.error("GraphQL request failed:", error);
    throw error;
  }
};

exports.registerUser = functions.https.onCall(async (data, context) => {
  const {email, password, displayName} = data || {};

  if (!email || !password || !displayName) {
    console.error("registerUser: missing fields", {
      email,
      password,
      displayName,
    });
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required information",
    );
  }

  try {
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName,
    });

    const claims = {
      "https://hasura.io/jwt/claims": {
        "x-hasura-default-role": "user",
        "x-hasura-allowed-roles": ["user"],
        "x-hasura-user-id": userRecord.uid,
      },
    };

    await admin.auth().setCustomUserClaims(userRecord.uid, claims);

    return {
      uid: userRecord.uid,
      email: userRecord.email,
      displayName: userRecord.displayName,
      success: true,
    };
  } catch (error) {
    console.error("registerUser error:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing register: " + (error.message || String(error)),
    );
  }
});

exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  const id = user.uid;
  const email = user.email;
  const name = user.displayName || "No Name";

  if (!id || !email) return null;

  const mutation = `
    mutation($id: String!, $email: String!, $name: String!) {
      insert_user(objects: [{ id: $id, email: $email, name: $name }]) {
        affected_rows
      }
    }`;

  try {
    return await makeGraphQLRequest(mutation, {id, email, name});
  } catch (error) {
    console.error("processSignUp error:", error);
    return null;
  }
});

exports.processDelete = functions.auth.user().onDelete(async (user) => {
  const id = user.uid;

  if (!id) return null;

  const mutation = `
    mutation($id: String!) {
      delete_user(where: {id: {_eq: $id}}) {
        affected_rows
      }
    }`;

  try {
    return await makeGraphQLRequest(mutation, {id});
  } catch (error) {
    console.error("processDelete error:", error);
    return null;
  }
});

exports.updateUserName = functions.https.onCall(async (data, context) => {
  const {id, name} = data || {};

  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated",
    );
  }

  if (!id || !name) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing id or name",
    );
  }

  if (context.auth.uid !== id) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Can only update own name",
    );
  }

  const mutation = `
    mutation($id: String!, $name: String!) {
      update_user(where: {id: {_eq: $id}}, _set: {name: $name}) {
        affected_rows
      }
    }`;

  try {
    const result = await makeGraphQLRequest(mutation, {id, name});
    await admin.auth().updateUser(id, {displayName: name});

    return {
      success: true,
      affected_rows: result.update_user.affected_rows,
    };
  } catch (error) {
    console.error("updateUserName error:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing user name update: " + (error.message || String(error)),
    );
  }
});
