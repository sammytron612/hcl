@extends('layouts.main')

@section('content')

<div id="wrapper" class="container-fluid p-0 p-md-2 h-100">
    @if (Session::has('success'))
               <div class="alert alert-warning alert-block">
                  <button type="button" class="close" data-dismiss="alert">×</button>
                  <strong>{{ Session::get('success') }}</strong>
               </div>
               <br>
           @php
               Session::forget('success');
           @endphp
      @endif
@php
    session(['previous' => url()->current()]);
@endphp
@livewire('search-component')
</div>
@endsection
