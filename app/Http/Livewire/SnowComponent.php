<?php

namespace App\Http\Livewire;

use Livewire\Component;
use App\Snows;
use Livewire\WithPagination;

class SnowComponent extends Component
{
    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $searchTerm;

    public function render()
    {
        
        if(!$this->searchTerm){
            $entries = Snows::paginate(15);
        }
        else
        {
            $entries = Snows::where(function ($q) {
                $q->where('title','like','%' . $this->searchTerm . '%')
                ->orWhere('description','like','%' . $this->searchTerm . '%');
                })->paginate(15);
        }

        return view('livewire.snow-component', [
            'entries' => $entries
        ]);
    }
}
