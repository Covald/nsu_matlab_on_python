cmake_minimum_required(VERSION 3.22)
project(nsu_matlab_on_python C)

set(CMAKE_C_STANDARD 11)

add_executable(nsu_matlab_on_python
        "gdz/0.1 kvur/korni.m"
        "gdz/0.1 kvur/kvur.m"
        "gdz/0.2 lissajous/animate.m"
        "gdz/0.2 lissajous/inputparam.m"
        "gdz/0.2 lissajous/lissajous.m"
        "gdz/1 pendulum/pendulum0.m"
        "gdz/1 pendulum/pendulum1.m"
        "gdz/1 pendulum/pendulum2.m"
        "gdz/1 pendulum/pendulum2dop.m"
        "gdz/1 pendulum/pendulum3.m"
        "gdz/1 pendulum/pendulum4.m"
        "gdz/1 pendulum/pendulum5.m"
        "gdz/1 pendulum/pendulum6.m"
        "gdz/1 pendulum/pendulum6test.m"
        "gdz/1 pendulum/pendulum7.m"
        "gdz/2 field/field1.m"
        "gdz/2 field/field2.m"
        "gdz/2 field/field3.m"
        "gdz/2 field/field4.m"
        "gdz/2 field/field5.m"
        "gdz/2 field/field5dop.m"
        "gdz/3 gas/BallsF8.m"
        "gdz/3 gas/example.m"
        "gdz/3 gas/gas1.m"
        "gdz/3 gas/gas1dop.m"
        "gdz/3 gas/gas2.m"
        "gdz/3 gas/gas3.m"
        "gdz/3 gas/gas3dop.m"
        "gdz/3 gas/gas4.m"
        "gdz/3 gas/gas4dop.m"
        "gdz/3 gas/gas5.m"
        "gdz/3 gas/gas6.m"
        "gdz/3 gas/gas6_2.m"
        "gdz/3 gas/gas6_fast.m"
        "gdz/3 gas/set_random.m"
        planets/determination_of_motion_parameters.m
        planets/Motion_with_additive.m
        planets/motion_with_interaction.m
        planets/thelAwkepler.m)
