set foo {
    a {
        aa { aa1 aa2 aa3 }
        ab { ab1 ab2 ab3 }
        ac { ac1 ac2 ac3 }
    }
    b {
        ba { ba1 ba2 ba3 }
        bb { bb1 bb2 bb3 }
        bc { bc1 bc2 bc3 }
    }
    c {
        ca { ca1 ca2 ca3 }
        cb { cb1 cb2 cb3 }
        cc { cc1 cc2 cc3 }
    }
}

dict for {key1 subdict} $foo {
    dict for {key2 list} $subdict {
        foreach elem $list {
            puts "$key1\t$key2\t$elem"
        }
    }
}
