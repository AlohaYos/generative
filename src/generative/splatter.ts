import {
  Point,
  randomize,
  pathFromPoints,
  svgImageFromPath,
} from "@/models/point";

// Artの生成実体部
const generatePoints = (count: number, length: number, dot: number) => {
  const points: Point[] = [];

  count = 3+randomize(10, 1.0);
  const r0 = 300;
  const rto = 0.588;
  const [cx, cy] = [512, 512]; 
  const speed = Math.PI*2 / count;  // 360deg/count=1回のループで進む角度

  for (let i = 0; i < Math.PI * 2; i += speed) {
    const xx = randomize(r0, 1.0);
    const yy = randomize(r0, 1.0);
    const cc = randomize(2, 1.0);
    let ccc = true;
    if(cc>1.0) ccc = false;
    ccc=false;

    points.push({
      x: xx,
      y: yy,
      c: true,
      r: rto,
    });
  }

//  console.log("points=",points);

  return points;


/*
  count=5;
  const r0 = 300;
  const rto = 0.588;
  const [cx, cy] = [512, 512]; 
  const speed = Math.PI*2 / count;  // 360deg/count=1回のループで進む角度

  for (let i = 0; i < Math.PI * 2; i += speed) {
    points.push({
      x: cx + r0 * Math.cos(i),
      y: cy + r0 * Math.sin(i),
      c: true,
      r: rto,
    });
  }

  points.push({
    x: cx + r0 * Math.cos(0),
    y: cy + r0 * Math.sin(0),
    c: true,
    r: rto,
  });

  console.log("points=",points);

  return points;
*/
/*
  count=5;
  length=0.2;
  dot=0.35;
  console.log("count=",count);
  console.log("length=",length);
  console.log("dot=",dot);
  const [cx, cy] = [512, 512]; 
  const r0 = 280,
    speed = Math.PI / count;  // 360deg/count=1回のループで進む角度
  const rto = 0.588;
  console.log("speed=",speed);
  for (
    let i = speed, alt = 0, r1 = r0;
    i < Math.PI * 2;        // 360°
    //i += randomize(speed, 0.9), // 進む角度を若干ランダムにする
    i += speed,
      alt = (alt + 1) % 3,  // alt = 0,1,2,0,1,2...
      r1 = (randomize(r1, 0.2) * 2 + r0) / 3  // 基本となる本体の半径（直前の半径を影響させる）
  ) {
    if (alt == 0) { // 3回に1回（でっぱりがくっつかないように離している）
      const r = r1 * (1 + randomize(length, 1));  // 本体から飛び出る半径
      const arc = randomize(dot, 0.5);
      // 6つの点を配置して、コブのような形のパスをpoints配列に入れる
      points.push({
        x: cx + r1 * Math.cos(i - (speed * arc) / 2),
        y: cy + r1 * Math.sin(i - (speed * arc) / 2),
        c: false,
        r: rto,
      });
      points.push({
        x: cx + r * Math.cos(i - (speed * arc) / 2),
        y: cy + r * Math.sin(i - (speed * arc) / 2),
        c: false,
        r: rto,
      });
      points.push({
        x: cx + r * (1 + arc / 2) * Math.cos(i - speed * arc),
        y: cy + r * (1 + arc / 2) * Math.sin(i - speed * arc),
        c: false,
        r: rto,
      });
      points.push({
        x: cx + r * (1 + arc / 2) * Math.cos(i + speed * arc),
        y: cy + r * (1 + arc / 2) * Math.sin(i + speed * arc),
        c: false,
        r: rto,
      });
      points.push({
        x: cx + r * Math.cos(i + (speed * arc) / 2),
        y: cy + r * Math.sin(i + (speed * arc) / 2),
        c: false,
        r: rto,
      });
      points.push({
        x: cx + r1 * Math.cos(i + (speed * arc) / 2),
        y: cy + r1 * Math.sin(i + (speed * arc) / 2),
        c: false,
        r: rto,
      });
    } else {  // 3回に2回は本体の半径でパスを描く
      points.push({
        x: cx + r1 * Math.cos(i),
        y: cy + r1 * Math.sin(i),
        c: false,
        r: rto,
      });
    }
  }

  console.log("points=",points);

  return points;
*/
};

export const generateSVGImage = (color: string) => {
  const points = generatePoints(
    randomize(30, 0.5),   // count
    randomize(0.2, 0.5),  // length
    randomize(0.3, 0.5)   // dot
  );
  const path = pathFromPoints(points);
  return svgImageFromPath(path, color);
};
