<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Comments;
use App\Articles;
use \App\Http\Helpers\Rating;
use Illuminate\Support\Facades\DB;
use App\Notifications\CommentAdded;
use App\Http\Helpers\FCMNotification;
use App\User;


class CommentsController extends Controller
{


    public function addComment(Request $request)
    {


        $new_comment = new Comments;
        $new_comment->articleid = $request->articleid;
        $new_comment->comment = $request->comment;
        $new_comment->userid = auth()->user()->id;
        $new_comment->rating = $request->rating;

        $instance = new Rating;

        $article = Articles::find($new_comment->articleid);
        $user = User::find($article->author);

        $data['title'] = $article->title;
        $data['commentor'] = auth()->user()->name;
        $data['comment'] = $new_comment->comment;

        $user->notify(new CommentAdded($data));

        $fcmMessage = new FCMNotification;

        $message = $data['commentor'] . ", commented on your article" .chr(10);
        $message .= "'". $data['title'] . "'" . chr(10);
        $data['comment'] = $message;

        $fcmMessage->send($data,$user->id);

        $response = $new_comment->save();

        if($response)
        {
            $ret = $instance->avg_comment_rating($request->articleid);
            return response()->json("success");}
         else
        {
            return response()->json("failure");
        }
    }

    public function viewComments()
    {

        $comments['comments'] = DB::table('comments')->select('comment','name','title','comments.rating','comments.created_at')
        ->leftJoin('users','comments.userid','=','users.id')
        ->leftJoin('articles','comments.articleid','=','articles.id')->orderBy('comments.created_at','desc')
        ->paginate(10);

        return view('admin.view_comments', $comments);
    }


}
