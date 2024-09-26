#!/bin/bash

echo "Press Enter to start the test..."
read

echo " Loading .............................. Test 1 "
clear
echo -e "********** 1. Get all PETS **********  \n"
echo "curl http://localhost:3000/pets -s | jq . "
response=$(curl http://localhost:3000/pets -s)
echo "$response" | jq .
# Extract the ID of the first pet
first_pet_id=$(echo "$response" | jq -r '.[0].id')
echo -e  "  \n"

echo "Press Enter to continue to the next test..."
read

echo " Loading .............................. Test 2 "
clear

echo -e "********** 2. Get PET by ID ********** \n"
echo "curl http://localhost:3000/pets/${first_pet_id} -s | jq . " 
curl http://localhost:3000/pets/${first_pet_id} -s | jq .
echo -e  "  \n"
echo "Press Enter to continue to the next test..."
read

echo " Loading .............................. Test 3 "
clear

echo -e "********** 3. Creating new a PET ********** \n"
echo 'curl -X POST -H "Content-Type: application/json" -d '{"name": "Bella", "age": 2, "type": "dog"}' http://localhost:3000/pets -s'
response=$(curl -X POST -H "Content-Type: application/json" \
     -d '{"name": "Bella", "age": 2, "type": "dog"}' \
     http://localhost:3000/pets -s)

echo -e  "  \n"
#echo "$response" | jq .
# Extract the ID from the response
id=$(echo "$response" | jq -r .id)
echo "Press Enter to verify the new PET creation..."
read

echo -e "********** Verifying the new PET creation ********** \n"
# Use the extracted ID to make a GET request
echo "curl http://localhost:3000/pets/$id -s | jq ."
curl "http://localhost:3000/pets/$id" -s | jq .

echo -e  "  \n"
echo "Press Enter to continue to the next test..."
read

echo " Loading .............................. Test 4 "
clear

echo -e "********** 4. Updating a PET by id ********** \n"
echo 'curl -X PUT -H "Content-Type: application/json" -d '{"name": "Bella", "age": 3, "type": "dog"}' http://localhost:3000/pets/"${id}" -s'
curl -X PUT -H "Content-Type: application/json"  \
            -d '{"name": "Bella", "age": 3, "type": "dog"}' \
                http://localhost:3000/pets/$id -s

echo -e  "  \n"
echo "Press Enter to verify the PET update..."
read

echo -e "********** Verifying the PET update ********** \n"
echo "curl http://localhost:3000/pets/$id -s | jq ."
curl "http://localhost:3000/pets/$id" -s | jq .

echo -e  "  \n"
echo "Press Enter to continue to the next test..."
read

echo " Loading .............................. Test 5 "
clear

echo -e "********** 5. Deleting a PET by id ********** \n" 
echo "curl -X DELETE http://localhost:3000/pets/$id"
curl -X DELETE http://localhost:3000/pets/$id
echo -e  "  \n"
echo "Press Enter to verify the PET delete..."
read

echo -e "********** Verifying the PET delete ********** \n"
echo "curl http://localhost:3000/pets/$id -s | jq ."
curl "http://localhost:3000/pets/$id" -s | jq .
echo -e  "  \n"
echo "Press Enter to complete the test..."
read

echo " All tests Complete "
clear
