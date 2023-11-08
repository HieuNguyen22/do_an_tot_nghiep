<!DOCTYPE html>
<html>

<head>
    <title>Reset Password</title>
</head>

<body>
    <h1>Hello, {{ $name }}!</h1>
    <p>Your password has been successfully reset. Below is your new login information:</p>
    <p><strong>Email:</strong> {{ $email }}</p>
    <p><strong>New Password:</strong> {{ $password }}</p>
    <p>Please remember to change your password after logging in for the security of your account.</p>
    <p>Thank you and have a great day!</p>
</body>

</html>