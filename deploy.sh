docker build -t crazyeights/multi-client:latest -t crazyeights/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t crazyeights/multi-server:latest -t crazyeights/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t crazyeights/multi-worker:latest -t crazyeights/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push crazyeights/multi-client:latest
docker push crazyeights/multi-server:latest
docker push crazyeights/multi-worker:latest

docker push crazyeights/multi-client:$SHA
docker push crazyeights/multi-server:$SHA
docker push crazyeights/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=crazyeights/multi-server:$SHA
kubectl set image deployments/client-deployment client=crazyeights/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=crazyeights/multi-worker:$SHA
