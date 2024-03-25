FROM python:3.12.2

# Set the working directory in the container
ENV PYTHONUNBUFFERED True
# Copy the contents of the DeploySpeechML directory into the container at /app

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY DeploySpeechML/ .

# Install system dependencies (if needed)
# RUN apt-get update && apt-get install -y <package-name>

# Install dependencies
COPY DeploySpeechML/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn


# Command to run the Flask application with Gunicorn
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 model:app
