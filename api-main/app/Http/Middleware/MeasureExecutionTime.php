<?php

namespace App\Http\Middleware;

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Route;

use Closure;
use Illuminate\Http\Request;

class MeasureExecutionTime
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);
        
        // Calculate execution time
        $executionTime = (int)((microtime(true) - LARAVEL_START) * 1000);
        if ($executionTime > 1000) {
            Log::build([
                'driver' => 'single',
                'path' => storage_path('logs/slowApi.log'),
              ])->info($request . ' - Execution Time: ' . $executionTime . ' ms');
        }
        return $response;
    }
}
