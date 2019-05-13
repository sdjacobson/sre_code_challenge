FROM python

# Set the Work Directory
WORKDIR /usr/local/src

# Python Requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt

# Copy the project codes into the Work Directory
COPY . /usr/local/src/

# Expose port so that it's accessible to external connections
EXPOSE 5000

# Run the Flask application
CMD ["python", "main.py", "runserver"]
