.PHONY: format check format-check lint dev test docker help

# Format code automatically
format:
	@ruff format .

# Check code style and quality
check: format_check lint

# Check if code formatting is correct without changing files
format_check:
	@ruff format --check

# Run linting
lint:
	@ruff check

# Run the development server
dev:
	python -m app

# Run all tests
test:
	pytest -sv tests

# Build and run the docker container locally
docker:
	docker build -t viagemeconomica-backend .
	docker run -p 8000:8000 viagemeconomica-backend


# Show available targets
help:
	@echo "Available targets:"
	@echo "  format       - Format code automatically"
	@echo "  check        - Check code style and quality"
	@echo "  format-check - Check if code formatting is correct"
	@echo "  lint         - Run linting"
	@echo "  test         - Run all tests"
	@echo "  docker       - Build and run the docker container locally"
	@echo "  dev          - Run the development server"
	@echo "  help         - Show this help message"
