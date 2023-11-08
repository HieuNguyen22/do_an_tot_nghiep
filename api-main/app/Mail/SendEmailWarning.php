<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendEmailWarning extends Mailable
{
    use Queueable, SerializesModels;
    public $notification;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($notification)
    {
        $this->notification = $notification;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $content = [];
        $content['zone'] = $this->notification->group->zone->name;
        $content['group'] = $this->notification->group->name;
        $content['category'] = $this->notification->thing->category->name;
        $content['thing'] = $this->notification->thing->name;
        $content['type'] =  $this->notification->type;
        $titleEmail = "IoT";
        $content['valueNowThing'] =  $this->notification->value;
        if ($this->notification->type == 1) {
            $content['warningValue'] =  $this->notification->min_value;
            $titleEmail  = "CẢNH BÁO " . strtoupper($content['category']) . " THẤP Ở " . strtoupper($content['group']) . " TỪ HỆ THỐNG IOT";
        } else {
            $content['warningValue'] =  $this->notification->max_value;
            $titleEmail  = "CẢNH BÁO " . strtoupper($content['category']) . " CAO Ở " . strtoupper($content['group']) . " TỪ HỆ THỐNG IOT";
        }
        $content['time'] =  $this->notification->created_at;
        return $this->from('iot.devfast@gmail.com')
            ->subject($titleEmail)
            ->view('warning')
            ->with('content',  $content);
    }
}
