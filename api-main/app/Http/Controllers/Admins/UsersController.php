<?php

namespace App\Http\Controllers\Admins;

use App\Http\Controllers\Controller;
use App\Repositories\UsersRepository;
use App\Http\Requests\Admins\UsersRequest;
use App\Http\Requests\Admins\CreateUserWithNumberPhoneAndActiveCodeRequest;
use App\Http\Resources\Admins\Users\UsersResource;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    /**
     * @var Repository
     */
    protected $UsersRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->UsersRepository = new UsersRepository();
    }

    /**
     * Get data by multiple fields.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function index(Request  $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();

        $user = $this->UsersRepository->search($params);

        $users = $this->UsersRepository->gameTypes($user);
        $jsonUsers = UsersResource::collection($users);
        return $jsonUsers;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(UsersRequest $request)
    {
        try {
            $response = $this->UsersRepository->create($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonItem = new UsersResource($response);
        return $jsonItem;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $item = $this->UsersRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonItem = new UsersResource($item);

        return $jsonItem;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {
            $params = $request->all();
            unset($params['device_id']);
            $item = $this->UsersRepository->update($params, $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonItem = new UsersResource($item);

        return $jsonItem;
    }

    // /**
    //  * Remove the specified resource from storage.
    //  *
    //  * @param  int  $id
    //  * @return \Illuminate\Http\Response
    //  */
    // public function destroy($id)
    // {
    //     try {
    //         $result = $this->UsersRepository->delete($id);
    //     } catch (\Throwable $th) {
    //         return response()->json([
    //             'data' => ['errors' => ['exception' => $th->getMessage()]]
    //         ], 400);
    //     }

    //     return response($result);
    // }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function createUserWithNumberPhoneAndActiveCode(CreateUserWithNumberPhoneAndActiveCodeRequest $request)
    {
        try {
            $newUser = $this->UsersRepository->createUserWithNumberPhoneAndActiveCode($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonItem = new UsersResource($newUser);
        return $jsonItem;
    }
}
