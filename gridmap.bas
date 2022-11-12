Randomize Timer
_Title "MAPPENG"
$Resize:Stretch
Screen 13

Dim map(100, 100) As Integer
Dim temp(100, 100) As Integer
Dim final(100, 100) As Integer



w = 100

Cls
Locate 16, 9: Print "INITIALIZE GRID"

For y = 0 To (w - 1)
    For x = 0 To (w - 1)
        PSet (x + 4, y + 4), 4
        If (x Mod 2 = 0) And (y Mod 2 = 0) Then
            map(x, y) = 1
            PSet (x + 4, y + 4), 15
        End If
    Next x
    _Delay .01
Next y


steps = w ^ 2
likeliness = 2
min = (w * 5) '500


Sleep
Locate 16, 9: Print "DRAW PHASE          "
For y = 0 To (w - 1)
    For x = 0 To (w - 1)
        PSet (x + 4, y + 4), 4

        If steps > 0 Then
            If (x Mod 2 = 1) And (y Mod 2 = 0) Then
                If Int(Rnd * likeliness) = 1 Then map(x, y) = 1
            End If

            If (x Mod 2 = 0) And (y Mod 2 = 1) Then
                If Int(Rnd * likeliness) = 1 Then map(x, y) = 1
            End If

            steps = steps - 1
        End If
        If map(x, y) = 1 Then
            PSet (x + 4, y + 4), 15
        End If

    Next x
    _Delay .01
Next y
Locate 16, 9: Print "DRAW PHASE COMPLETE"
Sleep
Locate 16, 9: Print "CLEANING THE SINGLE POINTS"
For y = 0 To (w) - 1
    For x = 0 To (w) - 1

        mx = x

        my = y

        If (mx + 1) < w Then
            p1 = map(mx + 1, my)
        Else
            p1 = 0
        End If

        If (mx - 1) > 0 Then
            p2 = map(mx - 1, my)
        Else
            p2 = 0
        End If

        If (my + 1) < w Then
            p3 = map(mx, my + 1)
        Else
            p3 = 0
        End If

        If (my - 1) > 0 Then
            p4 = map(mx, my - 1)
        Else
            p4 = 0
        End If

        p = p1 + p2 + p3 + p4

        If p < 1 Then
            map(mx, my) = 0
        End If
    Next x
Next y


For y = 0 To (w - 1)
    For x = 0 To (w - 1)
        PSet (x + 4, y + 4), 4
        If map(x, y) = 1 Then
            PSet (x + 4, y + 4), 15
        End If

    Next x
    _Delay .01
Next y

Locate 16, 9: Print "ALL SINGLE POINTS GONE.    "
Sleep

Cls

For y = 0 To (w - 1)
    For x = 0 To (w - 1)
        PSet (x + 4, y + 4), 8
        'If (x Mod 2 = 0) And (y Mod 2 = 0) Then map(x, y) = 1
    Next x
    _Delay .01
Next y

For y = 0 To (w - 1)
    For x = 0 To (w - 1)
        If map(x, y) = 1 Then GoTo 10
    Next x

Next y
10


cur = 1
t = 0
Do
    t = 0
    temp(x, y) = map(x, y)
    If (x + 1) < w Then
        If (map(x + 1, y) = 1) And (temp(x + 1, y) = 0) Then temp(x + 1, y) = 2
    End If

    If (y + 1) < w Then
        If (map(x, y + 1) = 1) And (temp(x, y + 1) = 0) Then temp(x, y + 1) = 2
    End If

    If (y - 1) >= 0 Then
        If (map(x, y - 1) = 1) And (temp(x, y - 1) = 0) Then temp(x, y - 1) = 2
    End If

    If (x - 1) >= 0 Then
        If (map(x - 1, y) = 1) And (temp(x - 1, y) = 0) Then temp(x - 1, y) = 2
    End If



    Locate 16, 9: Print cur, "          "
    Locate 2, 30: Print "Min:"
    Locate 3, 30: Print min

    PSet (x + 4, y + 4), 10

    For y = 0 To (w - 1)
        For x = 0 To (w - 1)
            If temp(x, y) = 2 Then
                temp(x, y) = 1
                cur = cur + 1
                t = t + 1
                GoTo 20
            End If
        Next x
    Next y

    20

    If t = 0 Then

        For y = 0 To (w - 1)
            For x = 0 To (w - 1)
                If temp(x, y) = 1 Then
                    map(x, y) = 0
                    temp(x, y) = 0
                    If cur > min Then
                        final(x, y) = 1
                    End If
                End If
            Next x
        Next y



        For y = 0 To (w - 1)
            For x = 0 To (w - 1)
                PSet (x + 4, y + 4), 8
                If map(x, y) = 1 Then
                    PSet (x + 4, y + 4), 15
                End If
            Next x

        Next y
        'Print "okay"
        'Sleep

        For y = 0 To (w - 1)
            For x = 0 To (w - 1)
                If map(x, y) = 1 Then GoTo 10
            Next x
            ' _Delay .01
        Next y




    End If


    For yy = 0 To (w - 1)
        For xx = 0 To (w - 1)
            If final(xx, yy) = 1 Then
                PSet (xx + 4 + 103, yy + 4), 13
            End If
        Next xx
    Next yy

    _Delay .01

Loop

Do
Loop Until InKey$ = "q"


System
