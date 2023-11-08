<?php

namespace App\Console\Commands;

use App\Models\FriendRequest;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use Illuminate\Console\Command;

class RemoveFriendsRequest extends Command
{
    const FRIEND_ACCEPTED = 1;
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'RemoveFriendsRequest';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Remove Friends Request with status = 1 and created_at <= 7 days ago';

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
     * Remove Friend Request
     *
     * @return void
     */
    public function removeFriendRequest()
    {
        $dateNow = Carbon::now();
        $dateAgo = $dateNow->subDay(7);
        $listFriendRequest = FriendRequest::where('status', '=', self::FRIEND_ACCEPTED)
            ->whereDate('created_at', '<=', $dateAgo)
            ->delete();

        if ($listFriendRequest == 0) {
            return $this->line('Remove Friend Request Failed');
        }
        return $this->line('Remove Friend Request Successful');
    }
    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {

        try {
            $this->line('Start Remove Friends Request :' . ' ' . Carbon::now());
            $this->removeFriendRequest();
            $this->line('End Remove Friends Request :' . ' ' . Carbon::now());
        } catch (\Throwable $th) {
            Log::error('exception: ' .  $th->getMessage());
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
    }
}
