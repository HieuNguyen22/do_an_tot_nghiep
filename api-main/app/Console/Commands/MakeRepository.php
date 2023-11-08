<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Console\GeneratorCommand;
use Illuminate\Support\Facades\File;
use InvalidArgumentException;

class MakeRepository extends GeneratorCommand
{
    private $model;
    /**
     * The name of your command. 
     * This is how your Artisan's command shall be invoked.
     */
    protected $name = 'make:repository';
    /**
     * A short description of the command's purpose.
     * You can see this working by executing
     * php artisan list
     */
    protected $description = 'Create a new repository class';


    /**
     * Class type that is being created.
     * If command is executed successfully you'll receive a
     * message like this: $type created succesfully.
     * If the file you are trying to create already 
     * exists, you'll receive a message
     * like this: $type already exists!
     */
    protected $type = 'Repository';

    /**
     * Specify your Stub's location.
     */
    protected function getStub()
    {
        return base_path() . '/stubs/repository.stub';
    }
    protected function replaceClass($stub, $name)
    {
        $class = str_replace($this->getNamespace($name) . '\\', '', $name);
        $position = strrpos($class, "Repository");
        $prefix = substr($class, 0, $position);
        $stub = str_replace(['DummyModel', '{{model}}', '{{ model }}'], $prefix, $stub);
        return str_replace(['DummyClass', '{{ class }}', '{{class}}'], $class, $stub);
    }

    /**
     * The root location where your new file should 
     * be written to.
     */
    protected function getDefaultNamespace($rootNamespace)
    {
        return $rootNamespace . '\Repositories';
    }
}