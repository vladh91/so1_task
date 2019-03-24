from elasticsearch import Elasticsearch


es = Elasticsearch()

response = es.search(index="test", doc_type="articles", body={"query": {"match": {"content": "Handbill not printed"}}})
occured_number = response['hits']['total'] #returns number of occurancies
if occured_number >= 3:
    print("There are 3 or more occurancies")



