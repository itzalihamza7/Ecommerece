# frozen_string_literal: true

users = [{
  name: 'Customer',
  email: 'customer@gmail.com',
  password: '111111',
  role: 0
},
         {
           name: 'Seller',
           email: 'seller@gmail.com',
           password: '111111',
           role: 1
         },
         {
           name: 'Admin',
           email: 'admin@gmail.com',
           password: '111111',
           role: 2
         }]
users.each do |user|
  User.find_by(email: user[:email]) || User.create(user)
end

User.find_by(email: 'customer@gmail.com').avatar.attach(io: File.open(Rails.root.join('lib/assets/images/user.JPEG')),
                                                        filename: 'user.JPEG')
User.find_by(email: 'seller@gmail.com').avatar.attach(io: File.open(Rails.root.join('lib/assets/images/user.JPEG')),
                                                      filename: 'user.JPEG')
User.find_by(email: 'admin@gmail.com').avatar.attach(io: File.open(Rails.root.join('lib/assets/images/user.JPEG')),
                                                     filename: 'user.JPEG')

seller = User.find_by(email: 'seller@gmail.com')

products = [{
  title: 'Product 0',
  description: 'Description 0 for product 0',
  price: 1000,
  quantity: 30
},
            {
              title: 'Product 1',
              description: 'Description 1 for product 1',
              price: 2000,
              quantity: 20
            },
            {
              title: 'Product 2',
              description: 'Description 2 for product 2',
              price: 3000,
              quantity: 10
            }]

products.each do |product|
  seller.products.find_by(title: product[:title]) || seller.products.create(product)
end

3.times do |i|
  Product.find_by(title: "Product #{i}").header_image.attach(
    io: File.open(Rails.root.join('lib/assets/images/product.webp')),
    filename: 'product.webp', content_type: 'image/webp'
  )
end

product = Product.find_by(title: 'Product 1')

comments = [{
  body: 'Comment 1 for product 1',
  user_id: User.find_by(email: 'customer@gmail.com').id
},
            {
              body: 'Comment 2 for product 1',
              user_id: User.find_by(email: 'seller@gmail.com').id
            },
            {
              body: 'Comment 3 for product 1',
              user_id: User.find_by(email: 'admin@gmail.com').id
            }]

comments.each do |comment|
  product.comments.find_by(body: comment[:body]) || product.comments.create(comment)
end
