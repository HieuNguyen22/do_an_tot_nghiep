<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>!!!Warning </title>
    <style>
        .text-red {
            color: red
        }

        .text-bold {
            font-weight: bold;
        }
    </style>
</head>

<body>

    <h1>CẢNH BÁO!!!</h1>
    <p>Chúng tôi phát hiện
        <span class="text-bold">{{ $content['group'] }}</span>
        trong trang trại của bạn đang có
        <span class="text-bold">{{ $content['category'] }} <?php echo $content['type'] == 0 ? "cao vượt" : "thấp dưới";   ?> mức cho phép</span>
    </p>
    <p><span class="text-bold">Thời gian :</span> {{ $content['time'] }} </p>
    <p><span class="text-bold">Khu vực :</span> {{ $content['zone'] }}</p>
    <p><span class="text-bold">Nhà :</span> {{ $content['group'] }}</p>
    <p><span class="text-bold">Thiết Bị :</span> {{ $content['thing'] }}</p>
    <p><span class="text-bold">
            <?php echo $content['type'] == 0 ? "Giới hạn lớn nhất" : "Mức độ nhỏ nhất : ";   ?></span> {{ $content['warningValue'] }}
    </p>
    <p><span class="text-bold">Giá trị của thiết bị hiện tại là :</span> {{ $content['valueNowThing'] }}</p>

    <p class="text-bold">Chi Tiết</p>
    <p>Thông số của
        <span class="text-red">{{ $content['thing'] }}</span> của 
        <span class="text-red"> {{ $content['group'] }}</span> thuộc 
        <span class="text-red">{{ $content['zone'] }} 
        <?php echo $content['type'] == 0 ? "đang vượt quá " : "ở dưới mức"; ?> 
        quy định cho phép là
            {{ $content['valueNowThing'] }} / {{$content['warningValue']}}
            .</span>
    </p>
    <p>Vui lòng truy cập hệ thống và kiểm tra</p>
    <p><a href="http://localhost:3030/dashboard2">[Link dashboard]</a></p>
    <p>Trân trọng,</p>
    <p>Cheetah IoT Management System</p>
    <p><i>Đây là email tự động từ hệ thống, vui lòng không trả lời email này</i></p>
</body>

</html>