def create_user(email)
  User.create(email: email, password: 'password', password_confirmation: 'password')
end

def sign_in(email)
  click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

def leave_review(thoughts, rating)
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
