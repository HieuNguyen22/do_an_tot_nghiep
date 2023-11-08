<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

 namespace App\Http\Services\Admins;

 use App\Repositories\ConfigBonusesRepository;
 use App\Repositories\ItemRepository;
 use Illuminate\Support\Facades\Storage;
class BaseService
{
    /**
     * Construct
     */
    public function __construct()
    {

    }

    /**
     * FileName
     *
     * @param [type] $fileName
     * @return void
     */

    public function fileName($fileName)
    {
        $fileName = time().'-'.$fileName;
        
        return $fileName;
    }

     /**
     * FileName + PartId
     *
     * @param [type] $fileName
     * @param [type] $parId
     * @return void
     */

    public function fileName_PartId($fileName,$parId)
    {
        $fileName = time().'-'.$parId.'-'.$fileName;
        
        return $fileName;
    }

     /**
     * Check Folder
     *
     * @param [type] $path
     * @return void
     */

    protected function checkFolder($path)
    {
        $pathFolder = public_path("$path/");
        if (!file_exists($pathFolder)) {
            Storage::makeDirectory($pathFolder, 0755, true);
        }
        return $pathFolder;
    }
}