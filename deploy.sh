docker build -t docker build -t ivanslavchev/multi-client:latest -t ivanslavchev/multi-client:$SHA -f ./clinet/Dockerfile ./client-f ./client/Dockerfile ./client
docker build -t ivanslavchev/multi-server:latest -t ivanslavchev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ivanslavchev/multi-worker:latest -t ivanslavchev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ivanslavchev/multi-client:latest
docker push ivanslavchev/multi-server:latest
docker push ivanslavchev/multi-worker:latest
docker push ivanslavchev/multi-client:$SHA
docker push ivanslavchev/multi-server:$SHA
docker push ivanslavchev/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ivanslavchev/multi-server:$SHA
kubectl set image deployments/client-deployment client=ivanslavchev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ivanslavchev/multi-worker:$SHA