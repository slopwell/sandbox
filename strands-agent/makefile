.PHONY: build

clean:
	rm --recursive --force ./terraform/aws/lambda.zip
	rm --recursive --force ./terraform/aws/layer.zip
	rm --recursive --force ./python/dist

dist:
	@echo "Freezing the project..."
	make clean
	mkdir -p ./python/dist/lambda
	mkdir -p ./python/dist/layer/python
	cd ./python && cp -r ./my_agent/* ./dist/lambda
	cd ./python && pip install -r ./my_agent/requirements.txt --target ./dist/layer/python
	@echo "Cleaning up layer to reduce size..."
	find ./python/dist/layer -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	find ./python/dist/layer -name "*.pyc" -delete
	find ./python/dist/layer -name "*.pyo" -delete
	find ./python/dist/layer -name "test*" -type d -exec rm -rf {} + 2>/dev/null || true
	find ./python/dist/layer -name "*test*" -type f -delete 2>/dev/null || true
	rm -rf ./python/dist/layer/*/tests 2>/dev/null || true
	# Remove unnecessary large packages
	rm -rf ./python/dist/layer/python/sympy 2>/dev/null || true
	rm -rf ./python/dist/layer/python/PIL 2>/dev/null || true
	rm -rf ./python/dist/layer/python/pillow* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/lxml 2>/dev/null || true
	rm -rf ./python/dist/layer/python/html5lib 2>/dev/null || true
	rm -rf ./python/dist/layer/python/slack* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/uvicorn 2>/dev/null || true
	rm -rf ./python/dist/layer/python/starlette 2>/dev/null || true
	rm -rf ./python/dist/layer/python/prompt_toolkit 2>/dev/null || true
	rm -rf ./python/dist/layer/python/pygments 2>/dev/null || true
	rm -rf ./python/dist/layer/python/opentelemetry 2>/dev/null || true
	rm -rf ./python/dist/layer/python/share 2>/dev/null || true
	rm -rf ./python/dist/layer/python/bin 2>/dev/null || true
	rm -rf ./python/dist/layer/python/boto* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/botocore* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/s3transfer* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/numpy* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/pandas* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/scipy* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/matplotlib* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/jupyter* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/IPython* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/notebook* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/ipykernel* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/ipywidgets* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/fastapi* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/pydantic* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/sqlalchemy* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/transformers* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/torch* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/tensorflow* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/wheel* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/setuptools* 2>/dev/null || true
	# Remove specific large packages that were seen in output
	rm -rf ./python/dist/layer/python/regex* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/typing_inspection* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/mcp* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/bs4* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/rich* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/referencing* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/readabilipy* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/anyio* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/boto3* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/wcwidth* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/tenacity* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/rpds* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/click* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/jsonschema* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/httpcore* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/pydantic_settings* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/aws_requests_auth* 2>/dev/null || true
	rm -rf ./python/dist/layer/python/mdurl* 2>/dev/null || true
	find ./python/dist/layer -name "*.so" -delete 2>/dev/null || true
	find ./python/dist/layer -name "*.dist-info" -type d -exec rm -rf {} + 2>/dev/null || true
	find ./python/dist/layer -name "*.egg-info" -type d -exec rm -rf {} + 2>/dev/null || true
	find ./python/dist/layer -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true

build:
	@echo "Building the project..."
	cd "./python/dist" && zip -r ../../terraform/aws/lambda.zip ./lambda && zip -r ../../terraform/aws/layer.zip ./layer
	@echo "=== Layer size check ==="
	@du -sh ./terraform/aws/layer.zip
	@ls -lh ./terraform/aws/layer.zip | awk '{print "Layer size: " $$5}'
	@echo "=== Lambda size check ==="
	@du -sh ./terraform/aws/lambda.zip
	@ls -lh ./terraform/aws/lambda.zip | awk '{print "Lambda size: " $$5}'
