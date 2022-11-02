@extends('layouts.mainDash')

@section('content')

<div class="container-fluid">
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
@php echo Session::get('otp');@endphp
<div class="mt-2 smokey p-5 border shadow">
    <h1><span class="text-primary fa fa-dashboard fa-1x mr-3"></span>Dashboard</h1>

<hr>

    <div class="row">
        <div class="col-md-6 align-items-stretch">
            <div class="card border shadow p-2">
                <chart1-component></chart1-component>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card border shadow p-2">
                <chart2-component></chart2-component>
            </div>
        </div>
    </div>

    <div class="row mt-1 pt-2">
        <div class="col-md-6">
            <div class="h-100 card border shadow p-2">
                <chart4-component></chart4-component>
            </div>
        </div>

        <div class="col-md-6">
            <div class="h-100 card border shadow p-2">
                <chart3-component></chart3-component>
            </div>
        </div>
    </div>
</div>
</div>
<div id="disclaimer" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Disclaimer</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>I agree to the terms of this site and will not post any information deemed as
              sensitive, such as (names, individual email addresses, passwords etc..)
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary"  data-dismiss="modal">Accept</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Dismiss</button>
        </div>
      </div>
    </div>
  </div>


@endsection
