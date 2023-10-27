<p> Hi <%= "#{@user&.first_name} #{@user&.middle_name} #{@user&.last_name}" %>, <p/>
<p>
  To reset your password please enter this code: <%= @code %>
</p>