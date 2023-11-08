<?php

namespace App\Observers;

use App\Events\SendMailWarning;
use App\Models\Thing;
use App\Repositories\NotificationRepository;
use Illuminate\Support\Facades\Event;

class ThingObserver
{
    /**
     * @var Repository
     */
    protected $notificationRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->notificationRepository = new NotificationRepository();
    }

    /**
     * Handle the Thing "created" event.
     *
     * @param  \App\Models\Thing  $thing
     * @return void
     */
    public function created(Thing $thing)
    {
        //
    }

    /**
     * Handle the Thing "updated" event.
     *
     * @param  \App\Models\Thing  $thing
     * @return void
     */
    public function updated(Thing $thing)
    {
        if ($thing->getOriginal('max_value') == $thing->max_value && $thing->getOriginal('min_value') == $thing->min_value && $thing->getOriginal('value') == $thing->value) {
            return;
        }


        if (is_null($thing->value) || is_null($thing->max_value) && is_null($thing->min_value)) {
            return;
        }

        $attributes = [
            "group_id" => $thing->group_id,
            "thing_id" => $thing->id,
            "min_value" => $thing->min_value,
            "value" => $thing->value,
            "max_value" => $thing->max_value
        ];
        if (!is_null($thing->min_value) && !is_null($thing->max_value)) {
            if ($thing->value < $thing->min_value) {
                $attributes['type'] = 1;
                $notification = $this->notificationRepository->create($attributes);
                Event::dispatch(new SendMailWarning($notification));
            } else {
                $notification = $this->notificationRepository->create($attributes);
                Event::dispatch(new SendMailWarning($notification));
            }
        }
        if (!is_null($thing->min_value)) {
            if ($thing->value < $thing->min_value) {
                $attributes['type'] = 1;
                $notification = $this->notificationRepository->create($attributes);
                Event::dispatch(new SendMailWarning($notification));
            }
        } else if (!is_null($thing->max_value)) {
            if ($thing->value > $thing->max_value) {
                $notification = $this->notificationRepository->create($attributes);
                Event::dispatch(new SendMailWarning($notification));
            }
        }
    }

    /**
     * Handle the Thing "deleted" event.
     *
     * @param  \App\Models\Thing  $thing
     * @return void
     */
    public function deleted(Thing $thing)
    {
        //
    }

    /**
     * Handle the Thing "restored" event.
     *
     * @param  \App\Models\Thing  $thing
     * @return void
     */
    public function restored(Thing $thing)
    {
        //
    }

    /**
     * Handle the Thing "force deleted" event.
     *
     * @param  \App\Models\Thing  $thing
     * @return void
     */
    public function forceDeleted(Thing $thing)
    {
        //
    }
}
