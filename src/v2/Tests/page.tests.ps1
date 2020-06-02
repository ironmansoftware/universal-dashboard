Describe "Page" {
    It "should have an error" {
        Enter-SeUrl "$Address/Test/Error" -Target $Driver
    }

    It "should have a single item" {
        Enter-SeUrl "$Address/Test/SingleItem" -Target $Driver
    }
}