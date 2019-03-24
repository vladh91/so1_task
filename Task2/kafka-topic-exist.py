import kafka
from kafka import KafkaClient

topic_needs_to_be_ckecked = "some topic"
kafka_nodes = ['kafka-host1', 'kafka-host2']

for node in kafka_nodes:
    kafka_client = kafka,KafkaClient(node)
    server_topics = kafka_client.topic_partitions # return list of topics
    if topic_needs_to_be_ckecked not in server_topics:
        print("%s does not contain topic %s" % (node, topic_needs_to_be_ckecked))
