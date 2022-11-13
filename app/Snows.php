<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Snows extends Model
{
  

    protected $fillable = ['title','tags','description','group'];
    public $timestamps = false;

    public function searchableAs()
    {
        return 'snow_index';
    }

}
