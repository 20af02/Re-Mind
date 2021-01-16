import os, uuid
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
import json

##python blob storage test
##preload credentials

with open('credentials.json', 'r') as f:
    creds = json.load(f)

connect_str = creds["azure_storage"]["connectionstring"]

# print (connect_str)

def store_embedding(embedding, filename):
    blob_service_client = BlobServiceClient.from_connection_string(connect_str)
    container_name = "faceembeddings"
    container_client = blob_service_client.get_container_client("faceembeddings") 
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=filename)
    
    blob_client.upload_blob(embedding)


def get_embedding(filename):
    blob = BlobClient.from_connection_string(conn_str=connect_str, container_name="faceembeddings", blob_name=filename)
    blob_data = blob.download_blob()
    bd = blob_data.content_as_bytes()

    return bd





# blob_service_client = BlobServiceClient.from_connection_string(connect_str)

# container_name = "faceembeddings"

# container_client = blob_service_client.get_container_client("faceembeddings") 

# blob_client = blob_service_client.get_blob_client(container=container_name, blob="test.txt")

# with open("test.txt", "rb") as data:
#     blob_client.upload_blob(data)


# print("\nListing blobs...")

# # List the blobs in the container
# blob_list = container_client.list_blobs()
# for blob in blob_list:
#     print("\t" + blob.name)
#     bn = blob.name
#     # with open("./t2.txt", "wb") as my_blob:
#     #     blob_data = blob.download_blob()
#     #     my_blob.writelines(blob_data.content_as_bytes())


# blob = BlobClient.from_connection_string(conn_str=connect_str, container_name="faceembeddings", blob_name=bn)

# # blob_data = blob.download_blob()
# # bd = str(blob_data.content_as_bytes().decode())

# # print(bd)

# with open("./BlockDestination.txt", "w") as my_blob:
#     blob_data = blob.download_blob()
#     # type(blob_data)
#     my_blob.writelines(str(blob_data.content_as_bytes().decode()))
