return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
        autoreload = true,
        refresh_interval_ms = 8,

        overwrite = {
            yank   = { enabled = true, default_animation = "fade" },
            paste  = { enabled = true, default_animation = "reverse_fade" },
            undo   = { enabled = true, default_animation = "fade" },
            redo   = { enabled = true, default_animation = "fade" },
            search = { enabled = true, default_animation = "pulse" },
        },

        animations = {
            fade = {
                max_duration = 350,
                min_duration = 200,
                easing = "outQuad",
                from_color = "Visual",
                to_color = "Normal",
            },
            reverse_fade = {
                max_duration = 350,
                min_duration = 200,
                easing = "outBack",
                from_color = "Normal",
                to_color = "Visual",
            },
            pulse = {
                max_duration = 400,
                min_duration = 300,
                pulse_count = 2,
                intensity = 1.2,
                from_color = "Search",
                to_color = "Normal",
            },
        },
    },
}
