<?php
return [
    'path' => '/upload/event/',
    'keySecret' => 'nbnbmn',
    'applyCheckSum' => true,
    'maintain_time' => '2023-01-01 10:10:20',
    'versionMushUpdate' => 1.21,
    'gift_code_type_for_all_user' => 0,
    'status_win' => 1,
    'user_status'=>[
        "Active" => 1,
        "Inactive" => 2,
    ],  
    'role_code'=>[
        'staff'=>1,
        'manager'=>2,
        'admin'=>3
    ],
    'buy_action_type' => [
        'UnlockLevel' => 50,
        'Add5Live' => 350
    ],
    'check_out_limit'=>3,
    'attendance_status' => [
        'checkedIn' => 1,
        'checkedOut' => 2,
        'checkoutLate' => 3,
    ],
    "type_checkin"=>[
        'location'=>1,
        'wifi'=>2,
    ],
    'plan_list' => [
        'RemoveAdd' => (object) [
            'id' => 10,
            'productId' => 'com.35us',
            'price' => 35
        ],
        'BuyForLife' => (object) [
            'id' => 11,
            'productId' => 'com.100us',
            'price' => 100
        ],
        'Buy1Month' => (object) [
            'id' => 12,
            'productId' => 'com.35us',
            'price' => 20
        ],
        'Buy3Month' => (object) [
            'id' => 13,
            'productId' => 'com.35us',
            'price' => 50
        ]
    ],

    'type_parts' => [
        'Topic' => 1,
        'Phonetic ' => 2,
        'Story' => 3,
        'BrainbreakReview' => 4,
        'Brainbreak' => 5,
    ],

    'element_type' => [
        'Word' => 1,
        'Phonetic' => 2,
        'Sentence' => 3,
    ],

    'song_type' => [
        'Normal' => 1,
        'Karaoke' => 2,
    ],
    'story_type' => 0,

    'page_type' => [
        'StartPage ' => 0,
        'Normal' => 1,
        'Interaction' => 2,
        'EndPage' => 3,
    ],

    'lession_type' => [
        'Normal' => 1,
        'Brainbreak' => 2
    ],

    'type_setting' => [
        'Email' => 1,
        'Hotline' => 2,
        'Fanpage' => 3,
        'Question' => 4
    ]

];