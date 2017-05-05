def create_user(email)
  User.create(email: email, password: 'password', password_confirmation: 'password')
end

def create_restaurant(name, description)
  user = User.first
  user.restaurants.create(name: name, description: description)
end

def sign_in(email)
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

def add_restaurant(name)
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def leave_review(name, thoughts, rating)
  visit '/restaurants'
  click_link "Review #{name}"
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

def edit_restaurant(old_name, new_name, new_description)
  visit '/restaurants'
  click_link "Edit #{old_name}"
  fill_in 'Name', with: new_name
  fill_in 'Description', with: new_description
  click_button 'Update Restaurant'
end
