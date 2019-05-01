build:
	docker build -t anz-webapp:latest .

run:
	docker run -p 8000:8000 anz-webapp:latest