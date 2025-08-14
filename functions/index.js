require("dotenv").config();

const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");

admin.initializeApp();

const makeGraphQLRequest = async (query, variables = {}) => {
  try {
    const response = await fetch(process.env.GRAPHQL_ENDPOINT, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-hasura-admin-secret": process.env.HASURA_ADMIN_SECRET,
      },
      body: JSON.stringify({
        query,
        variables,
      }),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();

    if (result.errors) {
      throw new Error(result.errors[0].message);
    }

    return result.data;
  } catch (error) {
    console.error("GraphQL request failed:", error);
    throw error;
  }
};

exports.registerUser = functions.https.onCall(async (request) => {
  const {email, password, displayName} = request.data;

  if (!email || !password || !displayName) {
    throw new Error("Missing required information");
  }

  try {
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: displayName,
    });

    const customClaims = {
      "https://hasura.io/jwt/claims": {
        "x-hasura-default-role": "user",
        "x-hasura-allowed-roles": ["user"],
        "x-hasura-user-id": userRecord.uid,
      },
    };

    await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);

    return {
      uid: userRecord.uid,
      email: userRecord.email,
      displayName: userRecord.displayName,
      success: true,
    };
  } catch (error) {
    throw new Error("Error processing register: " + error.message);
  }
});

exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  const id = user.uid;
  const email = user.email;
  const name = user.displayName || "No Name";

  if (!id || !email) {
    return null;
  }

  const mutation = `mutation($id: String!, $email: String!, $name: String!) {
    insert_user(objects: [{
      id: $id,
      email: $email,
      name: $name,
    }]) {
      affected_rows
    }
  }`;

  try {
    const data = await makeGraphQLRequest(mutation, {
      id: id,
      email: email,
      name: name,
    });

    return data;
  } catch (error) {
    return null;
  }
});

exports.processDelete = functions.auth.user().onDelete(async (user) => {
  const id = user.uid;

  if (!id) {
    return null;
  }

  const mutation = `mutation($id: String!) {
    delete_user(where: {id: {_eq: $id}}) {
      affected_rows
    }
  }`;

  try {
    const data = await makeGraphQLRequest(mutation, {
      id: id,
    });

    return data;
  } catch (error) {
    return null;
  }
});

exports.updateUserName = functions.https.onCall(async (request) => {
  const {id, name} = request.data;

  if (!request.auth) {
    throw new Error("User must be authenticated to update name");
  }

  if (!id || !name) {
    throw new Error("Missing required information: id or name");
  }

  if (request.auth.uid !== id) {
    throw new Error("User can only update their own name");
  }

  const mutation = `mutation($id: String!, $name: String!) {
    update_user(where: {id: {_eq: $id}}, _set: {name: $name}) {
      affected_rows
    }
  }`;

  try {
    const result = await makeGraphQLRequest(mutation, {
      id: id,
      name: name,
    });

    await admin.auth().updateUser(id, {
      displayName: name,
    });

    return {
      success: true,
      affected_rows: result.update_user.affected_rows,
    };
  } catch (error) {
    throw new Error("Error processing user name update: " + error.message);
  }
});
