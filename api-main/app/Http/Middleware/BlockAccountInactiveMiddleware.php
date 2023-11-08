<?php

namespace App\Http\Middleware;

use Closure;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class BlockAccountInactiveMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if(Auth::guard('app-users')->check()){
            $status = Auth::guard('app-users')->user()->status_code;
            if($status && $status == config('contant.user_status.Inactive')){
                return response()->json(['error' => 'Account has been Blocked'],403);
            }
        }
        return $next($request);
    }
}
