<div class="container-fluid p-2 h-100">
    
    <br>

    <div id="snowtable" class="p-3 p-md-5 smokey mt-5">
        <h1><span class="text-primary fa fa-snowflake-o fa-1x mr-3"></span><span>Snow groups</span>
        </h1>
        <div class="row my-3 mx-auto">
            <div class="input-group offset-md-3 col-md-6 col-12">
                <input wire:model.debounce500ms="searchTerm" class="form-control h3 py-2 search-input w-50 border-right-0 border" type="search" placeholder="Search a snow group" id="search">
                <span class="input-group-append">
                    <button class="btn btn-secondary border-left-0 border">
                        <i class="fa fa-search"></i>
                    </button>
                </span>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped table-style">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>&nbsp</th>
                    </tr>
                </thead>
                    <tbody>
                        @foreach($entries as $entry)
                        <tr>
                            <td>{{ $entry->title}}</td>
                            <td>{{ $entry->description}}</td>
                            <td>&nbsp</td>
                        </tr>
                        @endforeach
                    </tbody>

            </table>
        </div>

        <div style="" class="pagination mt-2">
            {{ $entries->links() }}
        </div>
    </div>

    <br>


</div>
