include ../.envrc

setup:
	cd ./cdk
	# Install Node.js dependencies including CDK and TypeScript locally
	npm install

	# Create a Python virtual environment (optional but recommended)
	python -m venv .venv
	source .venv/bin/activate

	# Install Python dependencies for the local development
	pip install -r requirements.txt

	# Install Python dependencies for lambda with correct architecture
	pip install -r requirements.txt --python-version 3.12 --platform manylinux2014_aarch64 --target ./packaging/_dependencies --only-binary=:all:


package:
	python ./bin/package_for_lambda.py

bootstrap:
	npx cdk bootstrap --profile $(AWS_PROFILE)

deploy:
	npx cdk deploy --profile $(AWS_PROFILE)
