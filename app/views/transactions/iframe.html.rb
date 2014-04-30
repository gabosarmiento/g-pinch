<h1><%= @job.user.name %></h1>
<p>Price: <%= formatted_price(@job.price) %></p>
<%= render 'form', user_id: @job.user_id, sale: @sale, price: formatted_price(@job.price) %>