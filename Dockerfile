# Use the base Laravel Sail image
FROM laravelsail/php82-composer AS base

# Set the working directory
WORKDIR /var/www/html

# Copy the existing application code
COPY . .

# Ensure the script has execution permissions
RUN chmod +x sail-setup.sh

# Run the setup script
RUN ./sail-setup.sh

# Expose the necessary port
EXPOSE 80

# Start the application
CMD ["./vendor/bin/sail", "up"]
