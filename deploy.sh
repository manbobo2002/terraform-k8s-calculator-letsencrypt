git add .
git commit -m "update"
SHA=$(git rev-parse --short HEAD)

docker build -t manbobo2002/multi-client:latest -t manbobo2002/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t manbobo2002/multi-server:latest -t manbobo2002/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t manbobo2002/multi-worker:latest -t manbobo2002/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push manbobo2002/multi-client:latest
docker push manbobo2002/multi-server:latest
docker push manbobo2002/multi-worker:latest

docker push manbobo2002/multi-client:$SHA
docker push manbobo2002/multi-server:$SHA
docker push manbobo2002/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=manbobo2002/multi-server:$SHA
kubectl set image deployments/client-deployment client=manbobo2002/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=manbobo2002/multi-worker:$SHA