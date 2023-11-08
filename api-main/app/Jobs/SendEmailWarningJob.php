<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;

class SendEmailWarningJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $emailReceived;
    public $notification;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($emailReceived, $notification)
    {
        $this->emailReceived = $emailReceived;
        $this->notification =  $notification;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        Mail::to($this->emailReceived)->send(new \App\Mail\SendEmailWarning($this->notification));
    }
}
