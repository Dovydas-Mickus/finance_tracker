
From given requirements:
    1. Home Screen:
        * Displays a summarized financial dashboard:
            * Total income.
            * Total expenses.
            * Current balance.
        * A scrollable list of all transactions (grouped by month, with expandable sections).
        * A button to navigate to the "Add Transaction" screen.
    2. Add/Edit Transaction Screen:
        * Allow users to add or edit a transaction.
        * Fields:
            * Title (String)
            * Amount (Double)
            * Type (Dropdown: Income/Expense)
            * Category (Dropdown: e.g., Food, Travel, Salary, etc.)
            * Date (Date Picker)
        * Validate user inputs before submission.
    3. Analytics Screen:
        * A pie chart to display category-wise expense distribution.
        * A line chart to show trends in balance over the past 6 months.
        * Provide options to filter the data by date range and transaction type.
    4. Data Persistence:
        * Use a local database ObjectBox to persist data.
        * Ensure the data is retrieved asynchronously and displayed correctly.
    5. Export/Import Data:
        * Allow users to export all transactions to a CSV file.
        * Allow users to import a CSV file to populate or update transactions.
    6. Advanced Interactions:
        * Add chart tooltips to display detailed data on hover or tap.
        * Support dark mode and light mode for the entire app.
    7. Testing:
    * Unit Testing:
        * Test Cubit logic (e.g., adding/editing/deleting transactions).
        * Validate input fields for the Add/Edit Transaction screen.

I was not able to complete tasks: 3, 5, 6, 7

