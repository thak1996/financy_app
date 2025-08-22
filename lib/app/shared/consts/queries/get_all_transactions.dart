const String queryGetAllTransactions = r'''
  query getAllTransactions {
    transaction(order_by: {date: desc}) {
      category
      created_at
      date
      description
      id
      status
      user_id
      value
    }
  }
''';