# Stage 1: Build stage
FROM python:3.9-alpine AS builder

# Install dependencies required for building Python packages
RUN apk add --no-cache build-base libffi-dev openssl-dev

# Set working directory
WORKDIR /app

# Copy application and requirements files
COPY requirements.txt .

# Install Python dependencies into a virtual environment
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .

# Stage 2: Runtime stage
FROM python:3.9-alpine

# Set a build argument for user and group name
ARG APP_USER=appdeploy
ARG APP_GROUP=appgroup

# Add a non-root user and group
RUN addgroup -S $APP_GROUP && adduser -S $APP_USER -G $APP_GROUP

# Set working directory
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache libffi openssl

# Copy application files
COPY app.py .

# Copy virtual environment from the builder stage
COPY --from=builder /app/venv /app/venv

# Set environment variable to use the virtual environment
ENV PATH="/app/venv/bin:$PATH"

# Change ownership of the application files to the non-root user
RUN chown -R $APP_USER:$APP_GROUP /app

# Switch to the non-root user
USER $APP_USER

# Run the application
CMD ["python", "app.py"]

