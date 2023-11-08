<?php

namespace App\Listeners;

use App\Events\SendMailWarning;
use App\Models\Admin;
use Illuminate\Support\Facades\Mail;

class SendMailWarningFired
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  SendMailWarning  $event 
     * @return void
     */
    public function handle(SendMailWarning $event)
    {
        $adminList = Admin::all();
        foreach ($adminList as $admin) {
            dispatch(new \App\Jobs\SendEmailWarningJob($admin->email, $event->notification));
        }
    }
}