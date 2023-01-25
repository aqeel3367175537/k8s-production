docker build -t aqeelraza12/multi-client:latest -t aqeelraza12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aqeelraza12/multi-server:latest -t aqeelraza12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aqeelraza12/multi-worker:latest -t aqeelraza12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aqeelraza12/multi-client:latest
docker push aqeelraza12/multi-server:latest
docker push aqeelraza12/multi-worker:latest

docker push aqeelraza12/multi-client:$SHA
docker push aqeelraza12/multi-server:$SHA
docker push aqeelraza12/multi-worker:$SHA

# Path: k8s
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=aqeelraza12/multi-server:$SHA
kubectl set image deployments/client-deployment client=aqeelraza12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aqeelraza12/multi-worker:$SHA