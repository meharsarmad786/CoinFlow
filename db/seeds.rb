# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Fetching cryptocurrency data from CoinGecko API..."
CryptoPriceService.update_cryptocurrency_prices
puts "✓ Cryptocurrency data loaded successfully!"

puts "\nCreating sample user..."
user = User.find_or_create_by!(email: 'demo@coinflow.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end
puts "✓ Sample user created: #{user.email}"

puts "\nCoinFlow is ready! 🚀"
puts "Login with: demo@coinflow.com / password123"
