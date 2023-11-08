<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class AutomationTest extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'automation:test {env} {typeUser}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Automation test is tool to test api';

    /**
     * attribute env.
     *
     * @var string
     */
    // dev env
    protected $baseApi = 'http://127.0.0.1:8000';
    protected $deviceId = 'aiksdhjioasehjdioszhfietdev-dfat';

    protected $userId = 0;
    protected $token = '';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $env = $this->argument('env');
        $typeUser = $this->argument('typeUser');

        // get env
        if ($env == 'dev') {
            $this->baseApi = 'http://127.0.0.1:8000';
        } else if ($env == 'test') {
            $this->baseApi = 'http://api-test.ring-toss.funpoint.us';
        } else if ($env == 'product') {
            $this->baseApi = 'http://api-prod.ring-toss.funpoint.us';
        }

        // get device
        if ($typeUser == 'old') {
            $this->deviceId = 'use_test_by_env_' . $env . '-dfat';
        } else {
            $this->deviceId = $this->generateRandomString(27) . '-dfat';
        }

        // create user play
        $this->line('CreateUserPlay: ' . $this->createUserPlay());

        // getLevel
        $this->line('GetLevel: ' . $this->getLevel());

        // saveLevel
        $this->line('SaveLevel: ' . $this->saveLevel());

        // syncLevel
        $this->line('SyncLevel: ' . $this->syncLevel());

        return 0;
    }

    function generateRandomString($length = 6)
    {
        $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    /**
     * get checksum
     */
    public function getChecksum($paramList, $txcs)
    {
        $checkSumOrigin = "";
        foreach ($paramList as $param) {
            if (is_array($param) == true) {
                foreach ($param as $item) {
                    $checkSumOrigin = $checkSumOrigin . "|" . $item;
                }
            } else {
                $checkSumOrigin = $checkSumOrigin . "|" . $param;
            }
        }
        $checkSumOrigin = substr($checkSumOrigin, 1);
        $checkSumOrigin = $checkSumOrigin . '|' . md5($txcs) . '||' . config('contant.keySecret');
        $checkSumOrigin = strtoupper($checkSumOrigin);
        $checkSumMd5 = md5($checkSumOrigin);
        $checkSumMd5 = strtoupper($checkSumMd5);
        return $checkSumMd5;
    }

    /**
     * test createUserPlay function.
     */
    public function createUserPlay()
    {
        try {
            $client = new \GuzzleHttp\Client();

            $txcs = (string)time();
            $param = [$this->deviceId, '0'];
            $checkSumMd5 = $this->getChecksum($param, $txcs);
            $headers = [
                'Platform' => 'Android',
                'Version' => 1.5,
                'Agent' => '',
                'txcs' => $txcs,
                'cs' => $checkSumMd5
            ];

            $res = $client->request('POST', $this->baseApi . '/api/users/createUserPlay?deviceId=' . $this->deviceId . '&gameType=0&timeZone=7', [
                'headers' => $headers
            ]);
            $bodyByJson = $res->getBody();
            $body = json_decode((string)$bodyByJson, true);
            $device_id = $body["data"]["device_id"];
            if ($device_id == substr($this->deviceId, -12)) {
                $this->userId = $body["data"]["id"];
                $this->token = $body["data"]["token"];
                return 'true';
            } else {
                return 'false';
            }
        } catch (\Throwable $th) {
            return 'false';
        }
    }

    /**
     * test createUserPlay function.
     */
    public function getLevel()
    {
        try {
            $client = new \GuzzleHttp\Client();
            $headers = [
                'Authorization' => 'Bearer ' . $this->token,
                'Accept'        => 'application/json',
            ];

            $res = $client->request('GET', $this->baseApi . '/api/users/level/getLevel?page=1', [
                'headers' => $headers
            ]);
            $bodyByJson = $res->getBody();
            $body = json_decode((string)$bodyByJson, true);
            $numberLevel = count($body["data"]);
            if ($numberLevel > 0) {
                return 'true';
            }
            return 'false';
        } catch (\Throwable $th) {
            return 'false';
        }
    }

    /**
     * test createUserPlay function.
     */
    public function saveLevel()
    {
        try {
            $client = new \GuzzleHttp\Client();

            $body = [
                'status' => 1,
                'ring_type' => 'small_wood',
                'level' => 1,
                'star' => 3
            ];

            $txcs = (string)time();
            $checkSumMd5 = $this->getChecksum($body, $txcs);

            $headers = [
                'Authorization' => 'Bearer ' . $this->token,
                'content-type'        => 'application/json',
                'Platform' => 'Android',
                'Version' => 1.5,
                'Agent' => '',
                'txcs' => $txcs,
                'cs' => $checkSumMd5
            ];

            $res = $client->request('POST', $this->baseApi . '/api/users/userLevels/saveUserLevelResult', [
                'headers' => $headers,
                'body' => json_encode($body),
            ]);
            $bodyByJson = $res->getBody();
            $body = json_decode((string)$bodyByJson, true);
            $statusCode = $res->getStatusCode();
            if ($statusCode == '200') {
                return 'true';
            }
            return 'false';
        } catch (\Throwable $th) {
            return 'false';
        }
    }

    /**
     * test createUserPlay function.
     */
    public function syncLevel()
    {
        try {
            $client = new \GuzzleHttp\Client();

            $param = [
                'dataList' => [
                    [
                        'status' => 1,
                        'ring_type' => 'small_wood',
                        'level' => 1,
                        'star' => 3
                    ],
                    [
                        'status' => 1,
                        'ring_type' => 'small_wood',
                        'level' => 2,
                        'star' => 3
                    ],
                    [
                        'status' => 1,
                        'ring_type' => 'small_wood',
                        'level' => 3,
                        'star' => 3
                    ]
                ]
            ];

            $txcs = (string)time();
            $paramsJson = json_encode(["dataList" => $param['dataList']]);
            $paramsJson = strtoupper($paramsJson);
            $paramsJson = str_replace(":NULL", ':""', $paramsJson);
            $paramsJson = str_replace('\/', '/', $paramsJson);
            $checkSumMd5 = $this->getChecksum([$paramsJson], $txcs);

            $headers = [
                'Authorization' => 'Bearer ' . $this->token,
                'content-type'        => 'application/json',
                'Platform' => 'Android',
                'Version' => 1.5,
                'Agent' => '',
                'txcs' => $txcs,
                'cs' => $checkSumMd5
            ];

            $res = $client->request('POST', $this->baseApi . '/api/users/userLevels/syncLevelResult', [
                'headers' => $headers,
                'body' => json_encode($param),
            ]);
            $bodyByJson = $res->getBody();
            $body = json_decode((string)$bodyByJson, true);
            $statusCode = $res->getStatusCode();
            if ($statusCode == '200') {
                return 'true';
            }
            return 'false';
        } catch (\Throwable $th) {
            return 'false';
        }
    }
}
