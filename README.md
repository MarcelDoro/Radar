# Distance calculation explanation
As everyone should know from physics

$$v=\frac{s}{t}$$

so

$$s=v*t$$

We know that $v\approx 343\frac{m}{s}$ (speed of sound)

$$343\frac{m}{s}=343*\frac{100cm}{1 000 000\mu s}=0,0343\frac{cm}{\mu s}$$

The value of $t$ is known, because it's calcuclated by ultrasonic radar. For instance $t=~300\mu s$. Then

$$s=0,0343\frac{cm}{\mu s}*300\mu s = 10,29cm$$

We know that the distance is $10,29cm$ **but** we measured the time between radar and object **twice**. From radar to object, a sound wave bounced and returned back to radar. Due to this we have to divide our result by 2.

Our fincal distance is equal

$$\frac{s}{2}=\frac{v*t}{2}=\frac{10,29cm}{2}=\underline{5,145cm}$$