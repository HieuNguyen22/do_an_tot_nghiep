<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Log;

/**
 * @OA\Info(
 *     title="API Ring Toss",
 *     version="1.0.0"
 * )
 */
class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    protected function responseData($data)
    {
        return [
            'data' => $data
        ];
    }

    protected function checkSum($request, $paramList)
    {
        // Log::error('fullUrl: '. $request->fullUrl());
        if (!config('contant.applyCheckSum')) {
            return true;
        }
        
        $txcs = strtoupper($request->header('txcs'));
        $timeSend = substr($txcs, -10);
        $deviceId = strtoupper($request->header('DeviceId'));
        $checksum = strtoupper($request->header('cs'));

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

        // Log::error('Txcs: '. $txcs);

        $txcs = md5($txcs);
        $checkSumOrigin = $checkSumOrigin . "|" . $txcs . "|" . $deviceId ;
        $checkSumOrigin = $checkSumOrigin . "|" . config('contant.keySecret');

        $checkSumOrigin =strtoupper($checkSumOrigin);

        $checkSumMd5 = md5($checkSumOrigin);
        $checkSumMd5 =strtoupper($checkSumMd5);

        // Log::error('checkSumOrigin: '. $checkSumOrigin);
        // Log::error('checkSumMd5: '. $checkSumMd5);
        // Log::error('checksum: '. $checksum);
        
        if ($checkSumMd5 == $checksum) {

            // Check time send

            $timeSend = intval($timeSend);

            // Log::error('timeSend: '. $timeSend);
            $now = time();
            // Log::error('timeSend: '. $now);
            $deltaTime = abs( $timeSend - $now);

            // Log::error('abs: '. $deltaTime);
            if($deltaTime > 10) {
                return false;
            }

            return true;
        }

        return false;
    }
}
