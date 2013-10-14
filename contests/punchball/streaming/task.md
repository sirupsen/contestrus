Beatrice and Conrad want to stream a movie off Netflix, however, they really
hate buffering. They've come to you for help. They want to know how many seconds
`$t$` they should use for making popcorn so that they can watch the movie
without pauses.

Let's suppose the video's length is `$c$` seconds, and Beatrice and Conrad wait
`$t$` seconds before watching. Then for any moment of time `$t_0, t \le t_0 \le c + t$`
the size of data received in `$t_0$` seconds is not less than the size of data
needed to watch `$t_0 - t$` seconds of video.

Beatrice and Conrad would much rather watch the movie and have less time making
popcorn, so you must find the minimum for `$t$` for which the above condition
holds.

### Input
The first line contains three space-separated integers `$a, b, c$`
`$1 \le a, b, c \le 1000, a > b$`. The first number (`$a$`) denotes the size of
data needed to watch one second of the video. The second number (`$b$`) denotes the
size of data Beatrice and Conrad can download from the per second. The third
number (`$c$`) denotes the video's length in seconds.

### Output
Print a single number — the minimum integer number of seconds that Beatrice and
Conrad must wait to watch their movie without pauses.

### Sample input

In the first sample video's length is 1 second and it is necessary 4 units of
data for watching 1 second of video, so they should download `$4 \cdot 1 = 4$`
units of data to watch the whole video. The most optimal way is to wait `$3$`
seconds till `$3$` units of data will be downloaded and then start watching.
While they will be watching one second of the movie, one unit of data will be
downloaded and Beatrice and Conrad will have `$4$` units of data by the end of
watching. Also every moment till the end of video they will have more data then
necessary for watching.

    4 1 1
    #=> 3

In the second sample they need `$2 \cdot 10 = 20$` units of data, so they have
to wait `$5$` seconds and after that they will have `$20$` units before the second
second ends. However, if they wait `$4$` seconds, they will be able to watch
first second of video without pauses, but they will download `$18$` units of
data by the end of second second and it is less then necessary.

    10 3 2
    #=> 5

    13 12 1
    #=> 1
