import 'package:dash_agent/configuration/metadata.dart';
import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/configuration/command.dart';
import 'package:dash_agent/configuration/dash_agent.dart';
import 'commands/ask.dart';
import 'data_sources.dart';

/// [MyAgent] consists of all your agent configuration.
///
/// This includes:
/// [DataSource] - For providing additional data to commands to process.
/// [Command] - Actions available to the user in the IDE, like "/ask", "/generate" etc
class MyAgent extends AgentConfiguration {
  final docsDataSource = DocsDataSource();

  @override
  Metadata get metadata => Metadata(
      name: 'Vanna AI',
      avatarProfile: 'assets/logo.png',
      tags: ['SQL', 'database']);

  @override
  String get registerSystemPrompt =>
      '''Help users query SQL databases with Vanna AI. 
      
      Docs:
      
      $docsDataSource
      
      Answer from this and the other attached github examples and issues''';

  @override
  List<DataSource> get registerDataSources => [docsDataSource];

  @override
  List<Command> get registerSupportedCommands => [
        // AskCommand(docsSource: docsDataSource)
      ];
}

final docString = '''
https://vanna.ai/docs/
At its core, Vanna is a Python package that uses retrieval augmentation to help you generate accurate SQL queries for your database using LLMs.
How Vanna Works
Question

The user's question is fed into the system.

Vanna AI

Vanna AI processes the question and utilizes various sources to generate an SQL query.

Search

The system searches through available resources like:

DDL / Schemas

Documentation

Correct SQL Answers

Any Vector Store

Prompt

The question is used as a prompt for the AI model, along with the searched information.

Any LLM

Any Large Language Model (LLM) can be used to process the information and generate the SQL query.

SQL Query

The generated SQL query is displayed.

Execute

The SQL query is executed against the database.

Any SQL Database

The query can be run on any SQL database.

Results Correct?

Yes: The results of the query are checked for correctness. If correct, the process is complete.

No: If the results are incorrect, manual query rewrite is required.

Manual query rewrite

The user manually adjusts the SQL query based on the incorrect results.

Correct SQL Query

The final, correct SQL query is displayed.

Sql Query

The SQL query, potentially containing "select..." is used to generate data for visualizations.

Dataframe

The query results are stored in a dataframe.

Charts
Plotly

The dataframe is used to create charts and visualizations using a library like Plotly.

New Questions

The visualizations and results may prompt new follow-up questions.

AI generated follow-up questions

The system may automatically generate follow-up questions based on the results, facilitating further exploration.

Vanna works in two easy steps - train a RAG "model" on your data, and then ask questions which will return SQL queries that can be set up to automatically run on your database.
vn.train(...)

Train a RAG "model" on your data. These methods add to the reference corpus below.
vn.ask(...)

Ask questions. This will use the reference corpus to generate SQL queries that can be run on your database.


https://vanna.ai/docs/app/

Quickstart With Sample Data

Run Using Colab  Open in GitHub
!pip install vanna
import vanna
from vanna.remote import VannaDefault
vn = VannaDefault(model='chinook', api_key=vanna.get_api_key('my-email@example.com'))
vn.connect_to_sqlite('https://vanna.ai/Chinook.sqlite')
vn.ask("What are the top 10 albums by sales?")
from vanna.flask import VannaFlaskApp
VannaFlaskApp(vn).run()


https://vanna.ai/docs/FAQ/

Frequently Asked Questions

Can I use Vanna without an API Key?

Yes, the Vanna API key is only necessary if you're using Vanna-hosted components (i.e. LLM or vector store). If you already have access to an LLM and a vector store, you can use the Vanna python package without an API key.
We provide gpt-3.5-turbo for free so if you're looking for a quick and easy way to get started without having to pay, you can sign up for a free Vanna API key.
How do I get a Vanna API Key?

Get an API Key
How to I create a Vanna "model"?

Create a Vanna model here
Can I run this "offline"?

Yes. You can use Vanna with Ollama, which allows you to run your LLM offline and for the vector store, you can use ChromaDB. If you're actually running on a machine without an internet connection (i.e. Airgapped), you may need to do some fiddling with ChromaDB to pre-download the weights for the embedding function. Likewise you may need to pre-download the weights for the LLM.
Can I use this with my SQL database?

Yes. Vanna works with any SQL database that you can connect to with Python (which should be all of them). Vanna contains a number of pre-built connectors that you can use to connect to your database in one-line of code but you can always customize the connection.
What's necessary for Vanna to query your database is just a function called vn.run_sql which takes in a SQL query and returns a pandas DataFrame. If you can write a function that does that, you can use Vanna with your database. Here's an example:
import pandas as pd
import psycopg2

def run_sql(sql):
    conn = psycopg2.connect(
        host="localhost",
        database="my_database",
        user="my_user",
        password="my_password"
    )
    return pd.read_sql(sql, conn)

vn.run_sql = run_sql
vn.run_sql_is_set = True
How do I customize the ChromaDB path?

You can pass a 'path' parameter in the config object:
from vanna.chromadb.chromadb_vector import ChromaDB_VectorStore

class MyVanna(ChromaDB_VectorStore):
    def __init__(self, config=None):
        ChromaDB_VectorStore.__init__(self, config=config)

vn = MyVanna(config={'path': '/path/to/chromadb'})
These are six FAQ questions I believe are very frequent and the original FAQ does not answer
vn.ask is too slow, It can't stop loading on notebook

There could be many reasons for this but these are the most common 1. Plotly is unable to generate a plot of your data, set pass parameter visualize=False 2. LLM could not be responding, if you're using your own local LLM please check your API 3. SQL engine might be exhausted, please check with your DB admin
How can I see my training data? How can I edit it?

    Use `vn.get_training_data()` to see the dataframe of your training data. You can add training data whenever you run `vn.ask` or `vn.generate_sql`, with` auto_train = True`. You can remove training data using `vn.remove_training_data(id='id of row in training data')`. You can loop over all ids in `vn.get_training data` to remove all
Can I ask vanna to summarize the query results or use the results of the query to my liking?

    In the latest update of Vanna, we added the functionality of additional LLM functions. You can see here [link](https://vanna.ai/docs/behavior-customization/#adding-an-additional-llm-based-function)
How can connect my SQL DB to Vanna if, it is not one of those listed on the documentation

    You can connect to them but you will need to implement the methods listed [here](https://vanna.ai/docs/other-database-openai-vanna-vannadb/)
Vanna cannot stop training or doesn't train when I try to run the training plan?

There could be many reason's for this, these are the most common: 1) Your training data is larger than the context window of the model, try to truncate the plan or do one ddl statement at a time 2) Vanna takes the training plan in a specific format. Basically your plan dataframe must have all the columns in SELECT * FROM INFORMATION_SCHEMA.COLUMNS 3) There could be some corruption or unusual statements in the training plan
Whenever I do vn.ask() or vn.generate_sql() Vanna does not return anything just returns an error? Or Vanna returns gibberish statements with weird character strings.

These are probable causes for this: 1) Vanna has not been trained on sql statements 2) There is some corruption in the training data, for example it could be that there is some non-SQL statements added in the SQL training. There could be some examples with unintended characters, try removing some of the data or use vn.get_related_sql() or vn.get_related_ddl() to see which example in the training data is it referencing 3) LLMs can hallucinate, if the problem persist, please do try using a different LLM.


https://vanna.ai/docs/training-advice/


The Major Factor

The primary determinant of the output accuracy of the system is the quality of the training data. The most consequential training data is the known correct question to SQL pairs. This is a stylized diagram of what to expect:

The reason for this is that the system uses a retrieval augmentation layer to generate SQL queries. This layer is trained on a reference corpus of question-SQL pairs. The more question-SQL pairs that are known to be correct, the more accurate the system will be.
Question to SQL pairs contain a wealth of embedded information that the system can use to understand the context of the question. This is especially true when your users tend to ask questions that have a lot of ambiguity. The known correct SQL for a question actually encodes a lot of information:

The image breaks down the components of a well-written SQL query, using the question "What are the top 10 customers by sales?" as an example. Here's a breakdown:

1. The Question (You):

This is the starting point  the business question you're trying to answer with data.

2. The SQL Query:

This is the actual code written in SQL (likely a flavor like Snowflake SQL based on the example) to retrieve the data.

3. Anatomy Breakdown (Color-coded):

Preferences (Blue): This highlights choices made for readability or presentation, not affecting the core logic. Here, using c.c_name as customer_name is cleaner than displaying a raw ID.

Formulae (Orange): This points out any calculations or logic within the query. In this case, l.l_extendedprice * (1 - l.l_discount) calculates the actual sale price considering discounts.

Qualified Table Name (Blue): This emphasizes the importance of correctly referencing tables, especially if your database has multiple schemas or complex naming.

Joins (Blue): Joins combine data from different tables. This query uses them to link customer information, order details, and line items. Understanding foreign keys is crucial for proper joins.

Data Cleanliness (Blue): This section reminds you to consider data quality. Are null values handled appropriately? Do you need to cap outliers or apply any cleaning steps?

In essence, the image is trying to teach you that writing a good SQL query isn't just about getting the right answer, but also about:

Clarity: Making the code easy to read and understand.

Accuracy: Ensuring the logic correctly reflects the business question.

Maintainability: Using good practices so the query can be easily updated or modified in the future.

Efficiency: While not explicitly shown here, efficient queries are crucial, especially with large datasets.

When a new question comes in, even very small LLMs can take the example correct answer and make slight alterations to the SQL to fit the new question. The closer the known correct SQL is to the new question, the more accurate the system will be. In the example above, if the user were to ask "What are the top 5 customers by sales?" virtually any LLM will be able to answer that question accurately.
Always start in a Jupyter notebook

When first using the system, we generally recommend using it within Jupyter so that you have maximum control over the training data that you're feeding it and can perform bulk operations like extracting your database schema, etc.
Nudges / Hints

When you're first getting up and running, try giving some "hints" about your preferences when asking a question. For example, if you're asking a question about a specific table, you might want to include the table name in your question. This will help the system understand the context of your question and provide a more accurate answer.
SQL Statements

SELECT * FROM my_table is a BAD example of a SQL statement to train the system with. It's too generic and doesn't provide enough context for the system to understand the structure of the table. If you use a SQL statement to train, it's best to use statements that use column names. For example, SELECT id, name, email FROM my_table is a better example of a SQL statement to train the system with.

https://vanna.ai/docs/train/

vn.train

vn.train is a wrapper function that allows you to train the system (i.e. the retrieval augmentation layer that sits on top of the LLM). You can call it in these ways:
DDL statements

These statements give the system an understanding of what tables, columns, and data types are available.
vn.train(ddl="CREATE TABLE my_table (id INT, name TEXT)")
Documentation strings

These can be any abtirary documentation about your database, business, or industry that may be necessary for the LLM to understand how the context of a user's question.
vn.train(documentation="Our business defines XYZ as ABC")
SQL Statements

One of the most helpful things for the system to understand is the SQL queries that are commonly used in your organization. This will help the system understand the context of the questions that are being asked.
vn.train(sql="SELECT col1, col2, col3 FROM my_table")
Question-SQL Pairs

You can also train the system with question-SQL pairs. This is the most direct way to train the system and is the most helpful for the system to understand the context of the questions that are being asked.
vn.train(
    question="What is the average age of our customers?", 
    sql="SELECT AVG(age) FROM customers"
)
Question-SQL pairs contain a wealth of embedded information that the system can use to understand the context of the question. This is especially true when your users tend to ask questions that have a lot of ambiguity.
Training Plan

# The information schema query may need some tweaking depending on your database. This is a good starting point.
df_information_schema = vn.run_sql("SELECT * FROM INFORMATION_SCHEMA.COLUMNS")

# This will break up the information schema into bite-sized chunks that can be referenced by the LLM
plan = vn.get_training_plan_generic(df_information_schema)
plan

# If you like the plan, then uncomment this and run it to train
vn.train(plan=plan)
A training plan is basically just your database information schema broken up into bite-sized chunks that can be referenced by the LLM. This is a good way to train the system with a lot of data quickly.

https://vanna.ai/docs/ask/

vn.ask

vn.ask("What are the top 10 customers by sales?")
Remember
The system first needs training data before you can begin asking questions.

The ask function is intended to be a convenience method for use in Jupyter notebooks. You use this function to ask questions and it will run the following constituent functions:
vn.generate_sql
vn.run_sql
vn.generate_plotly_code
vn.get_plotly_figure
Note
If you are using Vanna outside of the context of a Jupyter notebook, you will should call these functions individually instead of using vn.ask. Since vn.ask runs several functions and does not return until all the functions are complete, you will experience a delay when using vn.ask in a non-notebook context.


https://vanna.ai/docs/behavior-customization/

Behavior Customization

All Vanna functions are inherited from the VannaBase class. This is an abstract base class that provides the basic functionality for all Vanna functions. Depending on the specifics of the configuration you choose, the implementations live within the classes that inherit from this base class.
You may choose to customize the behavior of Vanna by creating your own class that inherits directly from VannaBase or from one of the classes that inherit from it. This is useful if you want to change the behavior of a specific function or if you want to add new functionality.
Class Instantiation

This is an example of how the class is instantiated when configured to use the OpenAI API and the ChromaDB vector store.
To customize the specifics of the behavior, you can override any of the methods in the base classes when you're instantiating the MyVanna class.
from vanna.openai.openai_chat import OpenAI_Chat
from vanna.chromadb.chromadb_vector import ChromaDB_VectorStore

class MyVanna(ChromaDB_VectorStore, OpenAI_Chat):
    def __init__(self, config=None):
        ChromaDB_VectorStore.__init__(self, config=config)
        OpenAI_Chat.__init__(self, config=config)

vn = MyVanna(config={'api_key': 'sk-...', 'model': 'gpt-4-...'})
Overriding a Specific Function

Here's an example of how to override the is_sql_valid function.
from vanna.openai.openai_chat import OpenAI_Chat
from vanna.chromadb.chromadb_vector import ChromaDB_VectorStore

class MyVanna(ChromaDB_VectorStore, OpenAI_Chat):
    def __init__(self, config=None):
        ChromaDB_VectorStore.__init__(self, config=config)
        OpenAI_Chat.__init__(self, config=config)

    def is_sql_valid(self, sql: str) -> bool:
        # Your implementation here

        return False

vn = MyVanna(config={'api_key': 'sk-...', 'model': 'gpt-4-...'})

# Example usage
is_valid = vn.is_sql_valid("SELECT user_name, user_email FROM users WHERE user_id = 123")
print(f"Is the SQL valid? {is_valid}")
Adding an Additional LLM-based Function

If you want to add a new function that uses the LLM, you can do so by adding a new method to the class. Let's say that you want to "explain" a SQL query. You can add a new method to the class that uses the LLM to generate an explanation for the SQL query.
from vanna.openai.openai_chat import OpenAI_Chat
from vanna.chromadb.chromadb_vector import ChromaDB_VectorStore

class MyVanna(ChromaDB_VectorStore, OpenAI_Chat):
    def __init__(self, config=None):
        ChromaDB_VectorStore.__init__(self, config=config)
        OpenAI_Chat.__init__(self, config=config)

    def generate_query_explanation(self, sql: str):
        my_prompt = [
            self.system_message("You are a helpful assistant that will explain a SQL query"),
            self.user_message("Explain this SQL query: " + sql),
        ]

        return self.submit_prompt(prompt=my_prompt)

vn = MyVanna(config={'api_key': 'sk-...', 'model': 'gpt-3.5-turbo'})

vn.generate_query_explanation("SELECT user_name, user_email FROM users WHERE user_id = 123")
Output: 'This SQL query is selecting the user_name and user_email columns from the users table. It is specifying a condition using the WHERE clause, where the user_id column must equal 123. In other words, it is retrieving the user_name and user_email of the user whose user_id is 123.'

https://vanna.ai/docs/postgres-openai-vanna-vannadb/

Generating SQL for Postgres using OpenAI via Vanna.AI (Recommended), Vanna Hosted Vector DB (Recommended)

This notebook runs through the process of using the vanna Python package to generate SQL using AI (RAG + LLMs) including connecting to a database and training. If you're not ready to train on your own database, you can still try it using a sample SQLite database.
Run Using Colab  Open in GitHub
Which LLM do you want to use?

OpenAI via Vanna.AI (Recommended)
Use Vanna.AI for free to generate your queries
OpenAI
Use OpenAI with your own API key
Azure OpenAI
If you have OpenAI models deployed on Azure
Anthropic
Use Anthropics Claude with your Anthropic API Key
Ollama
Use Ollama locally for free. Requires additional setup.
Google Gemini
Use Google Gemini with your Gemini or Vertex API Key
Mistral via Mistral API
If you have a Mistral API key
Other LLM
If you have a different LLM model
Where do you want to store the 'training' data?

Vanna Hosted Vector DB (Recommended)
Use Vanna.AIs hosted vector database (pgvector) for free. This is usable across machines with no additional setup.
ChromaDB
Use ChromaDBs open-source vector database for free locally. No additional setup is necessary -- all database files will be created and stored locally.
Qdrant
Use Qdrants open-source vector database
Marqo
Use Marqo locally for free. Requires additional setup. Or use their hosted option.
Other VectorDB
Use any other vector database. Requires additional setup.
Setup

%pip install 'vanna[postgres]'
import vanna
from vanna.remote import VannaDefault
api_key = # Your API key from https://vanna.ai/account/profile 

vanna_model_name = # Your model name from https://vanna.ai/account/profile 
vn = VannaDefault(model=vanna_model_name, api_key=api_key)
Which database do you want to query?

Postgres
Microsoft SQL Server
MySQL
DuckDB
Snowflake
BigQuery
SQLite
Oracle
Other Database
Use Vanna to generate queries for any SQL database
 vn.connect_to_postgres(host='my-host', dbname='my-dbname', user='my-user', password='my-password', port='my-port')
Training

You only need to train once. Do not train again unless you want to add more training data.
# The information schema query may need some tweaking depending on your database. This is a good starting point.
df_information_schema = vn.run_sql("SELECT * FROM INFORMATION_SCHEMA.COLUMNS")

# This will break up the information schema into bite-sized chunks that can be referenced by the LLM
plan = vn.get_training_plan_generic(df_information_schema)
plan

# If you like the plan, then uncomment this and run it to train
# vn.train(plan=plan)
# The following are methods for adding training data. Make sure you modify the examples to match your database.

# DDL statements are powerful because they specify table names, colume names, types, and potentially relationships
vn.train(ddl="""
    CREATE TABLE IF NOT EXISTS my-table (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        age INT
    )
""")

# Sometimes you may want to add documentation about your business terminology or definitions.
vn.train(documentation="Our business defines OTIF score as the percentage of orders that are delivered on time and in full")

# You can also add SQL queries to your training data. This is useful if you have some queries already laying around. You can just copy and paste those from your editor to begin generating new SQL.
vn.train(sql="SELECT * FROM my-table WHERE name = 'John Doe'")
# At any time you can inspect what training data the package is able to reference
training_data = vn.get_training_data()
training_data
# You can remove training data if there's obsolete/incorrect information. 
vn.remove_training_data(id='1-ddl')

```## Asking the AI
Whenever you ask a new question, it will find the 10 most relevant pieces of training data and use it as part of the LLM prompt to generate the SQL.
```python
vn.ask(question=...)
Launch the User Interface

vanna-flask
from vanna.flask import VannaFlaskApp
app = VannaFlaskApp(vn)
app.run()


''';
